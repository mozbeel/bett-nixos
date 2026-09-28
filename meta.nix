rec {
  stateVersion = "26.05";
  dir = "/home/${user.name}/nixos";
  

  user = {
    name = "leeb";
    fullName = "Matthias Leeb";
  };

  domain = "matleeb.lol";
  
  git = {
    username = "mozbeel";
    email = "matthiasleeb4@gmail.com";
  };

  time.zone = "Europe/Vienna";

  keyboard = {
    layout = "us";
    variant = ",qwerty";
  };

  cuda = false;
}
