{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix 
	];

	#BOOT
	boot = {
		loader = {
			grub = {
				device = "nodev";
				efiSupport = true;
				efiInstallAsRemovable = true;
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
			xorg.libxcvt
			pciutils
			discord
			unstable.byedpi
			telegram-desktop
			heroic
			leafpad
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
	#HARDWARE
	hardware = {
		pulseaudio = {
			enable = true;
		};
	};
	#NIXPKGS
	nixpkgs = {
		config = {
			allowUnfree = true;
			packageOverrides = pkgs: {
				unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
			};
			allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    				"steam"
    				"steam-original"
    				"steam-run"
  			];
		};
	};
	#PROGRAMS
	programs = {
		steam = {
			enable = true;
  			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  			localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
		};
	};

	system.stateVersion = "24.05";
}
