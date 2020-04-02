{ pkgs, ... }:
{
  users                                 =
  {
    users.sivizius                      =
    {
      extraGroups                       =
      [
        "wheel"
      ];
      initialPassword                   =   "1337";
      isNormalUser                      =   true;
      openssh.authorizedKeys.keys       =
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDR1eqjiJKg2fUHpCBQxVyqfaiJMhUsN0UOO6uAzm04bbEOYb+iFGV/6IZ65egQ2UmBzbghU7Wm0ngfk8PNsfZkwtfQGm9VNcU00O7gNxH29/HaRZ1fhjFVTtJCw8AQmgVlz7/bgGb2Tpr9KjuUI/R1Lmp68/2JEhmP1Uztl8mbf82vW8dpIHVlUO+YlCrP03EAFJPnTyYGv74Fw7COJCdUHmfpuOO/38sOe89nSzUskws9CjxJ4D0tG3v323EOPcY2hs0xa1mZQY/FV96Cj6Cr5XH0TKqfe7LI2MDhzven/loANRQaR1YuZ0FW59Hf4V8xBLpVhho5gCx7oJH99K20rc7agDzKy1tt61Yd/nK2Fp5xUkOvKd3ZDdXbrPuK2fPaSyNZHQBBI2zdld/jGsmCFc3sUTIleghUAPNyc/kVmyXqdI3y9UwIN6y5Ed7PwhRiLlQjdI54B9/ANI/WO7phk7d4V6G0sNMeNXFji5hiHGxKfsroVsb3aW3PdUbjfpc="
      ];
      shell                             =   pkgs.zsh;
    };
  };
}
