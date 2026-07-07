{outputs, inputs}: {
  additions = final: prev:
    (import ../pkgs {pkgs = final;})
    // {
      wallpapers = import ../wallpapers {pkgs = final;};
    };

  modifications = final: prev: {
    # ...
  };
}
