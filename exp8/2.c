#include <stdio.h>
#include <stdbool.h>

bool checkFunctionalDependency(int attribute1[], int attribute2[], int size) {
    for (int i = 0; i < size; i++) {
        if (attribute1[i] != attribute2[i]) {
            return false;
        }
    }
    return true;
}

int main() {
    int attribute1[] = {1, 2, 3, 4, 5};
    int attribute2[] = {10, 20, 30, 40, 50};
    int size = sizeof(attribute1) / sizeof(attribute1[0]);

    bool isFunctionalDependency = checkFunctionalDependency(attribute1, attribute2, size);

    if (isFunctionalDependency) {
        printf("Functional dependency exists.\n");
    } else {
        printf("Functional dependency does not exist.\n");
    }

    return 0;
}

// /tmp/vcrXMAFyR5.o
// Functional dependency does not exist.


// === Code Execution Successful ===