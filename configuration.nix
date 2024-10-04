{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix 
	];

	#BOOT
	boot = {
		loader = {
			efi = {
				canTouchEfiVariables = true;
			};
			grub = {
				device = "nodev";
				efiSupport = true;
			};
		};
	};
	#NETWORK
	networking = {
		hostName = "nixos"; #Hostname
		networkmanager = { #Use Network Manager
			enable = true;
		};
	};
	#TIME
	time = {
		timeZone = "Asia/Krasnoyarsk";
	};
		#LOCALES
	i18n = {
		defaultLocale = "en_US.UTF-8";
	};
	#ENV
	environment = {
		systemPackages = with pkgs; [ #Общесистемные пакеты
			neovim
			git
		];
	};
	#USERS
	users = {
		users = {
			qqshkaevth = {
				isNormalUser = true;
				extraGroups = ["wheel" "networkmanager"];
				packages = with pkgs; [ #Пакеты для конкретного пользователя
					firefox
				];
			};
		};
	};
	#SECURTITY
	security = {
		sudo = {
			enable = true;
			extraConfig = ''
				Defaults passwd_timeout=0 #отключение таймаута пароля
				Defaults targetpw #Запрос пароля root
			'';
		};
	};
	#SERVICES
	services = {
		xserver = {
            		enable = true;
			desktopManager = {
				xterm.enable = false;
				xfce.enable = true;
			};
        	};
		displayManager = {
			defaultSession = "xfce";
		};
    	};
}
