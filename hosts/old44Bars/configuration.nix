{ config, pkgs, ... } :

let
	nixos-hardware = builtins.fetchTarball "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz";
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
	themes = pkgs.callPackage ../../derivs/sddm-themes.nix {};
    gugi-font = pkgs.callPackage ../../derivs/gugi-font.nix {  };
    dancing-script = pkgs.callPackage ../../derivs/dancing-script.nix{  };
in
{
	imports = [
		#<nixos-hardware/microsoft/surface/surface-pro-intel> # import surface kernel
		(import "${nixos-hardware}/microsoft/surface/surface-pro-intel")
		(import "${home-manager}/nixos")
		./hardware-configuration.nix
	];

	#surface specifics
	microsoft-surface.ipts.enable = true;
	microsoft-surface.surface-control.enable = true;

	# change location of the configuration.nix file
	nix.nixPath = [ 
		"/home/pk/.nix-defexpr/channels"
		"nixos-config=/home/pk/nixos/hosts/44Bars/configuration.nix"
		"nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
		"/nix/var/nix/profiles/per-user/root/channels"
	];

	networking.hostName = "44Bars"; # Define your hostname.

	# logind behavior
	services.logind.extraConfig = ''
		HandlePowerKey=ignore
		HandleSuspendKey=ignore
		HandleHibernateKey=ignore
	'';

	services.picom.enable = true;

	nixpkgs.config.allowUnfree = true;

	environment.pathsToLink = [ "/libexec" ]; # needed for i3 blocks

	# Configure keymap in X11
	services.xserver = {
		enable = true;

		desktopManager = {
			xterm.enable = false;
			gnome.enable = true; #for icon theme in xorunalpp
		};
		windowManager.i3.enable = true;

		xkb = {
			layout = "de";
			variant = "neo_qwertz";
		};
	};

	services.displayManager = {
		defaultSession = "none+i3";
		sddm = {
			enable = true;
			enableHidpi = true;
			theme = "sugar-dark";
		};
	};

	# natural scrolling
	services.libinput.touchpad.naturalScrolling = true;

	environment.systemPackages = with pkgs; [
		iptsd
		brightnessctl # used for changing brightness
		home-manager
		kitty
		wget
		git
		direnv
		neofetch
		unzip
		python3
		acpilight
		feh
		xorg.xev
		xorg.xf86inputevdev
		xorg.xf86inputsynaptics
		xorg.xf86inputlibinput
		xorg.xorgserver
		xorg.xf86videoati
		thermald
		sddm-kcm
		themes.sddm-sugar-dark
		libsForQt5.qt5.qtgraphicaleffects
		# obsidian # this is not in home manager because the home manager version is not updated to fix the "Electron version 25.9.0 is EOL" issue
		networkmanager_dmenu
		usbutils
		udiskie
		udisks
		dbeaver
		(nerdfonts.override { fonts = [ "Iosevka" "CascadiaCode" "JetBrainsMono" ]; })
        font-awesome
        gugi-font
        dancing-script

	];

	# Create /var/lib/pgadmin with the correct permissions
	services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

	services.gvfs.enable = true;
	services.udisks2.enable = true;

	services.dbus.packages = with pkgs; [
		xfce.xfconf
	];

	services.udev.packages = with pkgs; [
		iptsd
	];

	systemd.packages = with pkgs; [
		iptsd
	];

	home-manager.users.pk = import ../../home/pk/home.nix; #import user config

	environment.variables = {
		EDITOR = "code";
		BROWSER = "chromium";
		TERMINAL = "kitty";
	};

	# console setup
	console = {
		earlySetup = true;
		font = "ter-i32b";
		packages = with pkgs; [ terminus_font ];
		keyMap = "de";
	};
	programs.zsh.enable = true;


	# enable bluetooth
	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	# adjust screen size for surface screen
	services.xserver.dpi = 180;
		environment.variables = {
		GDK_SCALE = "2";
		GDK_DPI_SCALE = "0.5";
		_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
	};

	nixpkgs.config.permittedInsecurePackages = [
		"openssl-1.1.1v"
		"electron-25.9.0"
	];

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.pk = {
		isNormalUser = true;
		description = "pk";
		extraGroups = [ "networkmanager" "wheel" "video" "surface-control"];
		packages = with pkgs; [];
		shell = pkgs.zsh;
	};

	nixpkgs.config.packageOverrides = pkgs: {
		vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
	};
	hardware.opengl = {
		enable = true;
		extraPackages = with pkgs; [
			intel-media-driver # LIBVA_DRIVER_NAME=iHD
			#vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
			vaapiVdpau
			libvdpau-va-gl
		];
	};

	system.stateVersion = "23.11";
}
