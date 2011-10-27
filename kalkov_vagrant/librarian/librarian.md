!SLIDE transition=turnDown incremental	
#gem librarian
A tool like bundler for chef cookbooks
<https://github.com/applicationsonline/librarian>

!SLIDE transition=turnDown commandline incremental
#Install & setup librarian
	$ gem install librarian #installs
	$ librarian-chef init #makes Cheffile
	$ nano Cheffile

!SLIDE transition=turnDown smaller incremental	
#Cheffile
	@@@ruby
		site 'http://community.opscode.com/api/v1'
  		cookbook 'build-essential'
  		cookbook "apt"
  		cookbook "couchdb"
  		cookbook "git"
  		cookbook "nodejs"
  		cookbook "sqlite"
  
  		cookbook 'redis',
    		  :git => 'git@github.com:kalkov/kalkov_redis_cookbook.git'

  		cookbook 'rvm',
         	  :git => 'git@github.com:kalkov/kalkov_rvm_cookbook.git'
   
  		cookbook 'rvm_passenger',
    		  :git => 'git@github.com:kalkov/kalkov_rvm_passenger_cookbook.git'
   
  		cookbook 'nginx',
   		   :git => 'git@github.com:kalkov/kalkov_nginx_cookbook.git'

!SLIDE transition=turnDown commandline incremental	
#Don't forget
	$ git rm -r cookbooks #if the directory is present
	$ echo cookbooks >> .gitignore
	$ mkdir cookbooks #librarian doesn't auto mkdir yet

!SLIDE transition=turnDown commandline incremental	
#Install cookbooks into ./cookbooks
	$ librarian-chef install --clean --verbose
