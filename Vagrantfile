Vagrant.require_version ">= 2.0.0", "< 2.2.15"
Vagrant.configure("2") do |config|                         
                                                           
  require 'yaml'                                           
  if File.file?('config.yaml')                             
    conf = YAML.load_file('config.yaml')                   
    # puts "Config: #{conf.inspect}\n\n"                     
  else                                                     
    raise "Configuration file 'config.yaml' does not exist"
  end                                                      
                                                           
  #config.vm.box =  conf['box'] || "ubuntu/focal64"        
                                                           
  # vagrant up demo5                                       
  if ARGV[1] and ARGV[1] != conf['vmname']                 
      conf['vmname'] = ARGV[1]                             
  end                                                      
                                                           
  conf['machines'].each do |vmname,ip,memory,cpus,box|     
    config.vm.define "#{vmname}" do |machine|              
      machine.vm.hostname = "#{vmname}"                    
      machine.vm.box = "#{box}"                            
      machine.vm.network "private_network", ip: "#{ip}"    
      machine.vm.provider "virtualbox" do |v|              
        v.memory = "#{memory}"                             
        v.cpus = "#{cpus}"                                 
        v.name = "#{vmname}"                               
      end
    
      machine.ssh.forward_x11 = true

      machine.vm.provision 'shell' do |shell|
        shell.path = conf['script_path'] + "/common-bootstrap.sh"
        if File.file?("scripts/#{vmname}.sh")
           shell.path = "scripts/#{vmname}.sh" 
        end
      end                                                
      config.trigger.before [ :up, :provision ] do |trigger|
        trigger.name = "[SCRIPTING]"
        trigger.info = "Syntax check"
        trigger.run = { path: conf['script_path'] + '/linter.sh' }
      end
      
      config.vm.synced_folder "C:/Users/Admin stagiaire.DESKTOP-8967908/projet/tmp/shared", "/var/www/html"
      config.vm.network "forwarded_port", guest: 80, host:8011
    end
  end                                                      
end                                                        
#for config in vagrant.configure('2')  