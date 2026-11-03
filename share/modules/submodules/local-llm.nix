{ lib, config, pkgs, ... }:

{
  options.local-llm.enable = lib.mkEnableOption "Enable local LLM server with llama.cpp and ST";

  config = lib.mkIf config.local-llm.enable {
    services = {
      llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp-rocm;
        settings = {
          flash-attn = "on";
          model = "/var/models/active-model.gguf";
          port = 8888;
        };
      };
      sillytavern = {
        enable = true;
        port = 8080;
        configFile = "/var/sillytavern/config.yaml";
      };
    };
  };
}
