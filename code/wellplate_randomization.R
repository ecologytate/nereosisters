# Creating random samples to rotate position of well plates within treatments
# Create a vector of objects A, B, and C
objects <- c("A", "B", "C")
# Set the number of repetitions
repetitions <- 14
# Create an empty matrix to store the results
results <- matrix(NA, nrow = repetitions, ncol = length(objects))
# Set the seed for reproducibility
set.seed(123)
# Perform the random assignment
for (i in 1:repetitions) {
  # Randomly shuffle the objects
  shuffled_objects <- sample(objects)
  # Assign the positions 1-3 to the shuffled objects
  results[i, ] <- shuffled_objects
}
# Print the results
print(results)