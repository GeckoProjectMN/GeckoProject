Sample init scripts and service configuration for geckocoind
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/geckocoind.service:    systemd service unit configuration
    contrib/init/geckocoind.openrc:     OpenRC compatible SysV style init script
    contrib/init/geckocoind.openrcconf: OpenRC conf.d file
    contrib/init/geckocoind.conf:       Upstart service configuration file
    contrib/init/geckocoind.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "geckocoincore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes geckocoind will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, geckocoind requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, geckocoind will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that geckocoind and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If geckocoind is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running geckocoind without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/geckocoin.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/geckocoind`  
Configuration file:  `/etc/geckocoincore/geckocoin.conf`  
Data directory:      `/var/lib/geckocoind`  
PID file:            `/var/run/geckocoind/geckocoind.pid` (OpenRC and Upstart) or `/var/lib/geckocoind/geckocoind.pid` (systemd)  
Lock file:           `/var/lock/subsys/geckocoind` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the geckocoincore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
geckocoincore user and group.  Access to geckocoin-cli and other geckocoind rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/geckocoind`  
Configuration file:  `~/Library/Application Support/GeckocoinCore/geckocoin.conf`  
Data directory:      `~/Library/Application Support/GeckocoinCore`
Lock file:           `~/Library/Application Support/GeckocoinCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start geckocoind` and to enable for system startup run
`systemctl enable geckocoind`

4b) OpenRC

Rename geckocoind.openrc to geckocoind and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/geckocoind start` and configure it to run on startup with
`rc-update add geckocoind`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop geckocoind.conf in /etc/init.  Test by running `service geckocoind start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy geckocoind.init to /etc/init.d/geckocoind. Test by running `service geckocoind start`.

Using this script, you can adjust the path and flags to the geckocoind program by
setting the GECKOCOIND and FLAGS environment variables in the file
/etc/sysconfig/geckocoind. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.geckocoin.geckocoind.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.geckocoin.geckocoind.plist`.

This Launch Agent will cause geckocoind to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run geckocoind as the current user.
You will need to modify org.geckocoin.geckocoind.plist if you intend to use it as a
Launch Daemon with a dedicated geckocoincore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
