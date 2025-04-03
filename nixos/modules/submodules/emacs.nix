{
  pkgs ? import <nixpkgs> { },
}:
let
  emmie = pkgs.emacs30-pgtk;
  emacsWithPackages = (pkgs.emacsPackagesFor emmie).emacsWithPackages;
in
# MELPA Stable:
emacsWithPackages (
  epkgs:
  (with epkgs.melpaStablePackages; [
    all-the-icons
    catppuccin-theme
    company
    counsel
    doom-modeline
    doom-themes
    evil-collection
    evil-nerd-commenter
    helpful
    ivy
    ivy-rich
    magit
    nix-mode
    org-bullets
    projectile
    rainbow-delimiters
    rainbow-identifiers
    #use-package
    visual-fill-column
    which-key
  ])
  # MELPA:
  ++ (with epkgs.melpaPackages; [
    elfeed
    ess
    general
    polymode
    telega
  ])
  # ELPA:
  ++ (with epkgs.elpaPackages; [ ement ])
)
