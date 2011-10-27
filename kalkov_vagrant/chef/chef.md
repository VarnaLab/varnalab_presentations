!SLIDE transition=turnDown incremental	
#gem chef
Reality-Based automation for the Cloud.
Chef is an open-source systems integration framework built specifically for automating the cloud. No matter how complex the realities of your business, Chef makes it easy to deploy servers and scale applications throughout your entire infrastructure. Because it combines the fundamental elements of configuration management and service oriented architectures with the full power of Ruby, Chef makes it easy to create an elegant, fully automated infrastructure.


!SLIDE transition=turnDown bullets incremental	
#In simple words : 
* A tool that can install and configure software packages from recipes you write in plain ruby language. 
* <https://github.com/opscode/chef> 

* <http://opscode.com>

!SLIDE transition=turnDown smaller incremental
#chef recipes 

	@@@ ruby 
		require "tmpdir"
		
		user "redis" do
		  system true
		
		  action :create
		end
		
		
		%w(/var/lib/redis, /var/log/redis).each do |dir|
		  directory(dir) do
		    owner "redis"
		    group "redis"
		
		    action :create
		  end
		end
		
		tmp = Dir.tmpdir
		case node[:platform]
		when "debian", "ubuntu"
		  # this assumes 32-bit base Vagrant box.
		  # built via brew2deb, http://bit.ly/brew2deb. MK.
		  %w(redis2-server_2.2.12+github1_i386.deb).each do |deb|
		    path = File.join(tmp, deb)
		
		    cookbook_file(path) do
		      owner "vagrant"
		      group "vagrant"
		    end
		
		    package(deb) do
		      action   :install
		      source   path
		      provider Chef::Provider::Package::Dpkg
		    end
		  end # each
		
		  bash "update rc.d" do
		    code <<-CODE
		    sudo update-rc.d redis-server defaults
		    sudo service redis-server start
		    CODE
		    user "root"
		
		    subscribes :run, resources(:package => "redis2-server_2.2.12+github1_i386.deb"), :immediately
		  end
		
		  service "redis-server" do
		    supports :restart => true, :status => true, :reload => true
		    action [:enable, :start]
		  end
		end # case
!SLIDE transition=turnDown bullets small
#Cookbook sources
* https://github.com/opscode/cookbooks
* https://github.com/travis-ci/travis-cookbooks
* https://github.com/cookbooks  
* https://github.com/kalkov

!SLIDE transition=turnDown bullets small
#chef-server 
* Chef can be run not only on your pc but as a server 
* We can make another presentation for chef-server



