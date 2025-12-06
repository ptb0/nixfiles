{ pkgs, ... }: {
  services = {
    printing.enable = true;
    
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
     
     syncthing = {
       enable = true;
       user = "lain";
       dataDir = "/home/lain/Documents/Sync";
       configDir = "/home/lain/.config/syncthing";
     };
     
     searx = {
       enable = true;
       redisCreateLocally = true;
       settings = {
         server.secret_key = "test";
         server.port = 8080;
         server.bind_address = "0.0.0.0";
         search.formats = [
           "html"
           "json"
           "rss"
         ];
       };
     };
  };  
}
