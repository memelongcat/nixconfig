{
  disko.devices = {
    disk = {
      my-disk = {
        device = "/dev/sda"; #целевой диск для установки
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = { #/boot
              type = "EF00";
              size = "500M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };    
            };
            swap = { #[swap]
	            size = "8G";
	            content = {
		            type = "swap";
		            resumeDevice = true; #resume for hibernation
	            };
            };
            root = { #/
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
