!SLIDE bullets incremental
# What is a vagrant ?

* Something ...
* moving from one place to another . 
* In human world it is called : 
* 'Gentleman of the road' 

!SLIDE bullets incremental transition=turnDown smbullets 
# What is vagrant in computers ?

* Some project coming with it's whole environment , which can easily settle down , configure itself and run .
* This process must be fully automated .
* Must be started with one simple command.    

!SLIDE bullets incremental transition=turnDown smbullets 
# What you take ? 

* Automatic VM creation on top of Oracle's VirtualBox
* Automated provisioning of VM using Chef/Puppet
* Full SSH
* Static IP
* Forward ports
* Shared folders
* Easy packaging of VM 
* Turn off when you are done
* Rebuild VM with one command 

!SLIDE bullets incremental transition=turnDown smbullets 
# gem Vagrant
* Vagrant uses the ruby programming language .
* A library is called gem in ruby world .
* <https://github.com/mitchellh/vagrant>

!SLIDE transition=turnDown commandline incremental
# Install Vagrant
	$ gem install vagrant  #installs
	$ vagrant box add lucid32 http://... #downloads box
	$ vagrant init #makes Vagrantfile ...
	$ vagrant up #builds

!SLIDE transition=turnDown commandline incremental
# Configure Vagrant
	$ nano Vagrantfile

!SLIDE transition=turnDown smaller
# Vagrantfile
		@@@ ruby     
			Vagrant::Config.run do |config|
			
			  config.vm.box = "lucid32"
			  
			  config.vm.network "33.33.33.10"
			  
			  # Forward a port from the guest to the host, which allows for outside
              # computers to access the VM
			  config.vm.forward_port("80", 80, 8080)
			  config.vm.forward_port("3010", 3010, 3030,:auto => true)
			  
			  # Share an additional folder to the guest VM. The first argument is
              # an identifier, the second is the path on the guest to mount the
              # folder, and the third is the path on the host to the actual folder.
			  config.vm.share_folder("v-root", "/vagrant", ".", :nfs => true)
			  config.vm.share_folder("v-srv", "/srv", "/srv", :nfs => true)
			end
			
			
!SLIDE transition=turnDown smaller commandline incremental
#Vagrant commands
	$ vagrant --help
	
		  vagrant box                        # Commands to manage system boxes
		  vagrant destroy                    # Destroy the environment, deleting the created virtual machines
		  vagrant halt                       # Halt the running VMs in the environment
		  vagrant help [TASK]                # Describe available tasks or one specific task
		  vagrant init [box_name] [box_url]  # Initializes the current folder for Vagrant usage
		  vagrant package                    # Package a Vagrant environment for distribution
		  vagrant provision                  # Rerun the provisioning scripts on a running VM
		  vagrant reload                     # Reload the environment, halting it then restarting it.
		  vagrant resume                     # Resume a suspended Vagrant environment.
		  vagrant ssh                        # SSH into the currently running Vagrant environment.
		  vagrant ssh_config                 # outputs .ssh/config valid syntax for connecting to this environment via ssh
		  vagrant status                     # Shows the status of the current Vagrant environment.
		  vagrant suspend                    # Suspend a running Vagrant environment.
		  vagrant up                         # Creates the Vagrant environment
		  vagrant version                    # Prints the Vagrant version information
!SLIDE transition=turnDown smaller commandline incremental
#Start vagrant 
	$ vagrant up
	$ vagrant ssh
	
!SLIDE transition=turnDown smaller incremental
#Install software on VM
	@@@ ruby
		Vagrant::Config.run do |config|
		  config.vm.provision :chef_solo do |chef|
		    chef.log_level = :debug # config.log_level
		    chef.cookbooks_path = "cookbooks"
		    chef.add_recipe 'build-essential'
		    chef.add_recipe "apt"
		    chef.add_recipe "couchdb"
		    chef.add_recipe "git"
		    chef.add_recipe "nodejs"
		    chef.add_recipe "redis"
		    chef.add_recipe "sqlite"
		    chef.add_recipe "nginx::source"
		    chef.add_recipe 'rvm_passenger'
		    chef.add_recipe 'rvm_passenger::nginx'
		    chef.add_recipe 'rvm'
		    chef.add_recipe 'rvm::user'
		    chef.add_recipe 'rvm::vagrant'
		  end
		end


