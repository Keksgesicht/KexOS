lib:
rec {
  lo = lib.optionals;
  fs = lib.filesystem;
  inherit (lib.lists) forEach;
  flatList = lib.lists.flatten;
  listFilesRec = fs.listFilesRecursive;
  concatStr = lib.strings.concatStrings;
}
