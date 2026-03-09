# Caddy Web Server - Config Examples

Caddy configurations, tips and tricks.

## Features

## Available (vhost) Templates

+ [Yourls](https://github.com/pothi/caddy/blob/main/sites/yourls.caddy-sample)
+ phpBB
+ WG Easy (WireGuard server)
+ [Catchall template](https://github.com/pothi/caddy/blob/main/sites/default.caddy).

If you are looking for WordPress examples, head over to [WP on Caddy](https://github.com/pothi/caddy-wp).

If you'd like to include something else, create a pull request.

## Performance

+ All static content have maximum expiration headers.
+ SSL session cache is enabled by default.
+ Brotli compression support.
+ Open file cache support.
+ Server-level 301 support (for http => https, non-www => www, etc).

## Security

TODO

## Compatibility

Tested with the following servers...

+ Debian 13 (Trixie)
+ Debian 12 (Bookworm)
+ Ubuntu 22.04 LTS (Jammy Jellyfish)
+ Ubuntu 20.04 LTS (Noble Numbat)

Tested with the following Caddy versions...

+ version 2.10.0 and above

If you have a free server to spare for testing, please contact me. Thank you.

### How to Deploy

A dedicated repo is coming soon!

### About me

+ I specialize in hosting (high-traffic) WordPress / PHP sites.
+ I'm one of the top contributors for the tag [Nginx in ServerFault](https://serverfault.com/users/102173/pothi-kalimuthu?tab=profile).
+ Have released couple of WordPress Plugins, one of them is specifically for high performance WordPress sites... [https://profiles.wordpress.org/pothi#content-plugins](https://profiles.wordpress.org/pothi#content-plugins).
+ Have two _active_ blogs... [Tiny WordPress Insights](https://www.tinywp.in/) and [Tiny Web Performance Insights](https://www.tinywp.com/).

### Can you implement it on my server?

Yes. I offer paid support and can implement it on your server. Minimum fee is USD50. Please [shoot me an email](mailto:pothi@protonmail.com).

### Have questions or just wanted to say hi?

Please ping me on [Twitter](https://x.com/pothi]) or [send me a message](https://www.tinywp.in/contact/).

If you find this repo useful, please spread the word! Suggestions, discussion on best practices, bug reports, future requests, forks are always welcome!
