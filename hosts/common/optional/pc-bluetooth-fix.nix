{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.bluez
  ];

  # ---- Permanently disable onboard Realtek Bluetooth radio ----
  # Deauthorizes the USB device at the kernel level so no driver ever
  # binds to it -- it will never register as an hci device at all.
  # idVendor/idProduct from: lsusb | grep -i blue
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTRS{idProduct}=="b850", ATTR{authorized}="0"
  '';
  environment.etc."wireplumber/wireplumber.conf.d/51-bluez-no-suspend.conf".text = ''
    monitor.bluez.rules = [
      {
        matches = [
          {
            node.name = "~bluez_output.*"
          }
          {
            node.name = "~bluez_input.*"
          }
        ]
        actions = {
          update-props = {
            session.suspend-timeout-seconds = 0
          }
        }
      }
    ]
  '';
  environment.etc."wireplumber/wireplumber.conf.d/52-bluez-sbc-only.conf".text = ''
  monitor.bluez.properties = {
    bluez5.codecs = [ "sbc" ]
  }
'';
}
