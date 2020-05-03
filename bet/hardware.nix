{ config, lib, pkgs, ... }:
{
  imports                               =
  [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot                                  =
  {
    extraModulePackages                 =   with config.boot.kernelPackages; [ acpi_call ];
    initrd                              =
    {
      availableKernelModules            =
      [
        "ahci"
        "ehci_pci"
        "firewire_ohci"
        "sd_mod"
        "sdhci_pci"
        "sr_mod"
        "usb_storage"
        "xhci_pci"
      ];
      kernelModules                     =   [ "acpi_call" ];
      loader                            =
      {
        grub                            =
        {
          device                        =   "nodev";
          efiSupport                    =   true;
          efiInstallAsRemovable         =   true;
          enable                        =   true;
          memtest86.enable              =   true;
          version                       =   2;
        };
      };
      luks.devices."nixos".device       =   "/dev/disk/by-label/encrypted";
      # luks.devices."nixos".device       =   "/dev/disk/by-uuid/fab4ad67-ab90-4113-b994-b347010f2911";
    };
    kernelModules                       =   [ "kvm-intel" ];
  };
  fileSystems                           =
  {
    "/"                                 =
    {
      device                            =   "/dev/disk/by-uuid/6ec7d726-6ef6-4e86-b382-2b4b6933f3e9";
      fsType                            =   "xfs";
    };
    "/boot"                             =
    {
      device                            =   "/dev/disk/by-uuid/C7DE-E0D7";
      fsType                            =   "vfat";
    };
  };
  nix.maxJobs                           =   lib.mkDefault 8;
  powerManagement.cpuFreqGovernor       =   lib.mkDefault "powersave";
  swapDevices                           =
  [
    {
      device                            =   "/dev/disk/by-uuid/d7553993-772b-4979-abae-9127c65bdb05";
    }
  ];
}
