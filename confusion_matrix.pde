void setup() {
  if (args != null) {
    if (args.length == 1) {
      File file=new File(sketchPath() + "/" + args[0]);
      if (file.exists()) {
        println("[OK]");
        String[] lines = loadStrings(file);
        println(lines[0]);
      } else {
        println("[ERROR] File does not exist, exiting.");
      }
    } else {
      println("[ERROR] More than 1 argument given, exiting.");
    }
  } else {
    println("[ERROR] No arguments given, exiting.");
  }
}
