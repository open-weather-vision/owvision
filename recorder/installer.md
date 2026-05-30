The installer is a cli which is used to install and update owrec or daemon.

It supports installing/upgrading to the latest version or a specific release using the `--target` option.

From user perspective the process is straightforward:

_Scenario 1: Fresh installation_
´´´sh
$ ./owrec_installer
Fetching latest release...
owrec is not installed yet, creating application folder...
Downloading owrec@0.0.2...
Initializing owrec...
✅ Installed owrec@0.0.2!

````

_Scenario 2: Upgrade available_
```sh
$ ./owrec_installer
Fetching latest release...
owrec@0.0.1 is currently installed, latest release is owrec@0.0.2.
Do you want to upgrade? (y/n) y
Downloading owrec@0.0.2...
Stopping owrec...
Moving binary to installation folder...
Starting owrec...
✅ Upgraded owrec to version 0.0.2!
````

_Scenario 3: No upgrade available_

```sh
$ ./owrec_installer
Fetching latest release...
owrec@0.0.2 is currently installed, latest release is owrec@0.0.2.
✅ owrec is up to date!
```
