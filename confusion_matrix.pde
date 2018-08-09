String[] labels;
int num_classes;
int[] num_class_samples;
int[][] matrix;
int cell_size = 20;
int spacing = cell_size / 4;
int border = 20;


void setup() {
  size(1400, 1400); // TODO: make dynamic based on matrix size.
  if (args == null) {
    println("[ERROR] No arguments given... exiting..");
    exit();
    return;
  }
  if (args.length != 1) {
    println("[ERROR] More than 1 argument given... exiting.");
    exit();
    return;
  }
  File file = new File(sketchPath() + "/" + args[0]);
  if (!file.exists()) {
    println("[ERROR] File does not exist... exiting.");
    exit();
    return;
  }
  String[] lines = loadStrings(file);
  labels = lines[0].substring(2).split(", ");
  num_classes = labels.length;
  lines = subset(lines, 1);
  matrix = read_matrix(lines, num_classes);
  num_class_samples = samples_per_class(matrix, num_classes);
}


int[][] read_matrix(String[] str_matrix, int matrix_size) {
  int[][] num_matrix = new int[matrix_size][matrix_size];
  for (int i = 0; i < matrix_size; i++) {
    String[] split_line = str_matrix[i].split(",");
    for (int j = 0; j < matrix_size; j++) {
      num_matrix[i][j] = Integer.parseInt(split_line[j]);
    }
  }
  return num_matrix;
}


int[] samples_per_class(int[][] matrix, int matrix_size) {
  int[] class_samples = new int[matrix_size];
  for (int y = 0; y < matrix_size; y++) {
    int class_sum = 0;
    for (int x = 0; x < matrix_size; x++) {
      class_sum += matrix[y][x];
    }
    class_samples[y] = class_sum;
  }
  return class_samples;
}


void draw() {
  background(102);
  textAlign(CENTER, CENTER);

  // print labels
  fill(color(0, 0, 0));
  for (int i = 0; i < num_classes; i++) {
    text(labels[i], border + (i + 1) * (cell_size + spacing), border);
  }
  for (int i = 0; i < num_classes; i++) {
    text(labels[i], border, border + (i + 1) * (cell_size + spacing));
  }

  // print matrix
  for (int y = 0; y < num_classes; y++) {
    for (int x = 0; x < num_classes; x++) {
      float relative_score = float(matrix[y][x]) / float(num_class_samples[x]);
      int relative_color = int(255 * relative_score);
      // TODO: make color range white-red.
      fill(relative_color);
      rect(border/2 + (x + 1) * (cell_size + spacing),
           border/2 + (y + 1) * (cell_size + spacing),
           cell_size, cell_size);
    }
  }
  save("confusion_matrix.png");
  exit();
}
