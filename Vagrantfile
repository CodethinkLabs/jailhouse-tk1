Vagrant.configure(2) do |config|
  config.vm.box = "debian/contrib-jessie64"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/src/kernel"
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    #vb.gui = true
    # Customize the VM:
    vb.memory = "2048"
    vb.cpus = "4"
  end

  config.vm.provision "shell" do |s|
      s.inline = "/src/kernel/vagrant_build.sh $1 $2"
      s.args = ["/src/kernel v4.8"]
  end
  
end
