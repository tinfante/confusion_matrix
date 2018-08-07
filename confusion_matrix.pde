void setup() {
  if (args != null) {
    if (args.length == 1) {
      File file=new File(sketchPath() + "/" + args[0]);
      if (file.exists()) {
        String[] lines = loadStrings(file);
        String[] header = lines[0].substring(2).split(", ");
        lines = subset(lines, 1);
        int[][] matrix = read_matrix(lines, lines.length, header.length);
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

int[][] read_matrix(String[] str_matrix, int matrix_rows, int matrix_cols) {
  int[][] num_matrix = new int[matrix_rows][matrix_cols];
  for (int i = 0; i < matrix_rows; i++) {
    String[] split_line = str_matrix[i].split(",");
    for (int j = 0; j < matrix_cols; j++) {
      num_matrix[i][j] = Integer.parseInt(split_line[j]);
    }
  }
  return num_matrix;
}
