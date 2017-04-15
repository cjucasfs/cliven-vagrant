$out_file = File.new('debug.log', 'w')
def $stdout.write string
    log_datas=string
    if log_datas.gsub(/\r?\n/, "") != ''
        log_datas=::Time.now.strftime("%d/%m/%Y %T")+" "+log_datas.gsub(/\r\n/, "\n")
    end
    super log_datas
    $out_file.write log_datas
    $out_file.flush
end
def $stderr.write string
    log_datas=string
    if log_datas.gsub(/\r?\n/, "") != ''
        log_datas=::Time.now.strftime("%d/%m/%Y %T")+" "+log_datas.gsub(/\r\n/, "\n")
    end
    super log_datas
    $out_file.write log_datas
    $out_file.flush
end

#-------------------------------------------------------------------------------------------------------------------------------

Vagrant.configure(2) do |config|
	config.ssh.keep_alive = true
	
	#config.vm.box = "Ecodev/ubuntu-server-1604"
	#config.vm.box = "ubuntu/xenial64" .. erro ao gerar usuario vagrant - bug vagrant x virtualbox relatado na internet
	config.vm.box = "bento/ubuntu-16.04"
	
	# For environment with proxy
	#config.vm.box_download_insecure=true
	#if Vagrant.has_plugin?("vagrant-proxyconf")
	#	config.proxy.enabled = true
	#	config.proxy.http     = "http://cache:3128"
	#	config.proxy.https    = "http://cache:3128"
	#	config.proxy.no_proxy = "localhost;127.0.0.1;.example.com;*.ans.gov.br;*anerbrasil.org.br;sala;ansprpent01;sapiens.agu.gov.br*;ans*;10.*"
	#end
	
	config.vm.define :web do |web_config|
		web_config.vm.network "private_network", ip: "192.168.50.5"
		web_config.vm.provision "shell", path: "manifests/bootstrap.sh"
		web_config.vm.provision "puppet" do |puppet|
			puppet.manifest_file = "web.pp"
		end
	end

	config.vm.provision "shell", path: "provision.sh"
	#config.vm.provision "shell", inline: <<-SHELL
		#.... commands ......
	#SHELL
	
	config.vm.provider "virtualbox" do |v|
		v.name = "cliven-development"
		v.gui = true
		v.memory = 4096
		v.cpus = 1
	end
end 
