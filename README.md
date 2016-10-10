# PgTune

[![Puppet
Forge](http://img.shields.io/puppetforge/v/Envek/pgtune.svg)](https://forge.puppetlabs.com/Envek/pgtune) [![Build Status](https://travis-ci.org/Envek/puppet-pgtune.png)](https://travis-ci.org/Envek/puppet-pgtune) [![Puppet Forge
Downloads](http://img.shields.io/puppetforge/dt/Envek/pgtune.svg)](https://forge.puppetlabs.com/Envek/pgtune/scores)

Puppet module for configuring PostgreSQL installations for optimal performance.

Heavily based on web version of [PgTune] utility by Alexey Vasiliev aka @le0pard. _Note: not all functionality is implemented yet._

Please note that such autoconfiguration is not absolutely optimal in every case and should be considered as "quick start" solution. Most probably at some point of time you will stop use this module and will pick `postgresql::server::config_entry` definitions from its `init.pp` with values optimal for you.


Installation
------------

### Using [librarian-puppet] _(recommended)_

Place in your `Puppetfile`

	mod 'Envek-pgtune'

And execute

	librarian-puppet install

### Just to install

Type on your Puppet master command:

	puppet module install Envek-pgtune

Usage
-----

To configure by default:

	include pgtune

To limit memory for PostgreSQL by a half of installed RAM:

	class { "pgtune":
		available_memory_mb => $memorysize_mb / 2,
	}

To specify database purpose and desired connection limit:

	class { "pgtune":
		$max_connections => 150,
		$db_type         => 'web',
	}

### Available DB types

 * `web`     - Web applications
 * `oltp`    - Online transaction processing systems
 * `dw`      - Data warehouses
 * `desktop` - Desktop applications
 * `mixed`   - Mixed type of applications (this is default)


Found a mistake? Have a question?
----------------------------------

Search for an (or open new) issue here: https://github.com/Envek/puppet-pgtune/issues or send a pull request!


Contributing
------------

 1. Fork it (<https://github.com/Envek/puppet-pgtune/fork>)
 2. Create your feature branch (`git checkout -b my-new-feature`)
 3. Make your changes
 4. Write tests for them, make sure that `rake test` passes
 5. Commit your changes (`git commit -am 'Add some feature'`)
 6. Push to the branch (`git push origin my-new-feature`)
 7. Create a new Pull Request


Boring legal stuff
------------------

> Copyright © 2015 Andrey Novikov
>
> MIT License
>
> Permission is hereby granted, free of charge, to any person obtaining
> a copy of this software and associated documentation files (the
> "Software"), to deal in the Software without restriction, including
> without limitation the rights to use, copy, modify, merge, publish,
> distribute, sublicense, and/or sell copies of the Software, and to
> permit persons to whom the Software is furnished to do so, subject to
> the following conditions:
>
> The above copyright notice and this permission notice shall be
> included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
> LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
> OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
> WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[PgTune]: http://pgtune.leopard.in.ua/
[librarian-puppet]: http://librarian-puppet.com/
