# Class: pgtune
#
# This module configures PostgreSQL instance for optimal usage of system resources.
# Based on the web version of the PgTune utility available at http://pgtune.leopard.in.ua/ by Alexey Vasiliev.
#
# Parameters:
#  available_memory_mb - amount of memory in megabytes that PostgreSQL may count on. Defaults to all available RAM.
#  max_connections     - How many concurrent connections should be handled (default depends on $db type, usually 100)
#  db_type             - database purpose. One of 'web', 'oltp', 'dw', 'desktop', or 'mixed' (default is 'mixed')
#
# Requires: puppetlabs/postgresql module.
#
# Sample Usage: include pgtune
#
#
class pgtune (
  $available_memory_mb = $memorysize_mb,
  $max_connections     = undef,
  $db_type             = 'mixed',
) {

  # Calculating values

  if $max_connections {
    $connections = $max_connections
  } else {
    $connections = $db_type ? {
      'web'     => 200,
      'oltp'    => 300,
      'dw'      =>  20,
      'desktop' =>   5,
      default   => 100,
    }
  }

  # Shared buffers
  case $db_type {
    'desktop': { $shared_buffers = $available_memory_mb / 16 }
    default:   { $shared_buffers = $available_memory_mb /  4 }
  }

  # Effective cache size
  case $db_type {
    'desktop': { $effective_cache_size = $available_memory_mb / 4 }
    default:   { $effective_cache_size = $available_memory_mb * 3 / 4 }
  }

  # Work memory
  case $db_type {
    'desktop': { $work_mem = ($available_memory_mb * 1024 - $shared_buffers * 1024) / ($connections * 3) / 6 }
    'dw':      { $work_mem = ($available_memory_mb * 1024 - $shared_buffers * 1024) / ($connections * 3) / 2 }
    'mixed':   { $work_mem = ($available_memory_mb * 1024 - $shared_buffers * 1024) / ($connections * 3) / 2 }
    default:   { $work_mem = ($available_memory_mb * 1024 - $shared_buffers * 1024) / ($connections * 3) }
  }

  # Maintenance work memory
  case $db_type {
    'dw':      { $maintenance_work_mem = $available_memory_mb / 8 }
    default:   { $maintenance_work_mem = $available_memory_mb / 16 }
  }

  # Checkpoint segments
  case $db_type {
    'oltp':    { $checkpoint_segments = 64 }
    'dw':      { $checkpoint_segments = 128 }
    'desktop': { $checkpoint_segments = 3 }
    default:   { $checkpoint_segments = 32 }
  }

  # Checkpoint completion target
  case $db_type {
    'web':     { $checkpoint_completion_target = 0.7 }
    default:   { $checkpoint_completion_target = 0.9 }
  }

  # Default statistics target
  case $db_type {
    'dw':      { $default_statistics_target = 500 }
    default:   { $default_statistics_target = 100 }
  }

  # Applying calculated values

  postgresql::server::config_entry { 'max_connections':
    value => $connections,
  }

  postgresql::server::config_entry { 'shared_buffers':
    value => inline_template('<%= @shared_buffers.floor %>MB'),
  }

  postgresql::server::config_entry { 'effective_cache_size':
    value => inline_template('<%= @effective_cache_size.floor %>MB'),
  }

  postgresql::server::config_entry { 'work_mem':
    value => inline_template('<%= @work_mem.floor %>kB'),
  }

  postgresql::server::config_entry { 'maintenance_work_mem':
    value => inline_template('<%= [2048, @maintenance_work_mem.to_i ].min.floor %>MB'),
  }

  postgresql::server::config_entry { 'checkpoint_segments':
    value => $checkpoint_segments,
  }

  postgresql::server::config_entry { 'checkpoint_completion_target':
    value => $checkpoint_completion_target,
  }

  postgresql::server::config_entry { 'wal_buffers':
    value => inline_template('<%= [16384, 3 * @shared_buffers / 100 * 1024 ].min.floor %>kB'),
  }

  postgresql::server::config_entry { 'default_statistics_target':
    value => $default_statistics_target,
  }

}

