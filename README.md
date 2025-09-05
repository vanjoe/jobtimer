# Job Timer

A simple script for keeping track of what time goes to what job. 

To install simply copy the `jt` file to somewhere in your path.

## Usage 

 * When you start or switch to a job run `jt JOBNAME`
 * When you stop a job run `jt STOP` 
 * To clear the database run `jt CLEAR`
 * To print out the database as human readable run `jt DUMP`
 
## Database

By default the database is created in `~/jobtimer.log` but if that 
doesn't work for you, the environment variable JT_DBASE overrides this.


# KDE Widget

To install the widget run:

```
rm -rf ~/.local/share/plasma/plasmoids/org.kde.plasma.jobtimer-widget/ && kpackagetool6 --install . --type Plasma/Applet
```


