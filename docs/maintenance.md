## Plugin management

All plugins are managed in the [packer configuration file](../lua/packer-config/init.lua) and locked to a version specified in the [packer.lock file](../packer.lock)  
If you wish to update a plugin, make sure it can play ball with the other installed plugins and if you're happy with the new verision, update the packer.lock by running `:PackerSnapshot packer.lock` in command mode.
