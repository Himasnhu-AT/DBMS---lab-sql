#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define MAX_ROWS 100
#define MAX_COLS 100

bool isFunctionalDependency(char table[MAX_ROWS][MAX_COLS], int numRows, int numCols, int attr1, int attr2) {
    for (int i = 0; i < numRows; i++) {
        for (int j = i + 1; j < numRows; j++) {
            if (table[i][attr1] == table[j][attr1] && table[i][attr2] != table[j][attr2]) {
                return false;
            }
        }
    }
    return true;
}

int main() {
    int numRows, numCols;
    printf("Enter the number of rows in the table: ");
    scanf("%d", &numRows);
    printf("Enter the number of columns in the table: ");
    scanf("%d", &numCols);

    char table[MAX_ROWS][MAX_COLS];
    printf("Enter the table data:\n");
    for (int i = 0; i < numRows; i++) {
        for (int j = 0; j < numCols; j++) {
            scanf(" %c", &table[i][j]);
        }
    }

    int attr1, attr2;
    printf("Enter the indices of the two attributes to check for functional dependency: ");
    scanf("%d %d", &attr1, &attr2);

    if (isFunctionalDependency(table, numRows, numCols, attr1, attr2)) {
        printf("The attributes at indices %d and %d are functionally dependent.\n", attr1, attr2);
    } else {
        printf("The attributes at indices %d and %d are not functionally dependent.\n", attr1, attr2);
    }

    return 0;
}

// /tmp/IalkexVejP.o
// Enter the number of rows in the table: 3
// Enter the number of columns in the table: 4
// Enter the table data:
// A B C D
// E F G H
// I J K L
// Enter the indices of the two attributes to check for functional dependency: 1 3
// The attributes at indices 1 and 3 are functionally dependent.


// === Code Execution Successful ===
