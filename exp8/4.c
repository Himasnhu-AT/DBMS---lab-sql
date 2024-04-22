#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define MAX_ATTRIBUTES 26

bool isAttributePresent(char set[], char attribute) {
    for (int i = 0; i < strlen(set); i++) {
        if (set[i] == attribute) {
            return true;
        }
    }
    return false;
}

void computeClosure(char attributes[], char functionalDependencies[][MAX_ATTRIBUTES], int numFDs) {
    char closure[MAX_ATTRIBUTES];
    strcpy(closure, attributes);

    bool closureChanged = true;
    while (closureChanged) {
        closureChanged = false;

        for (int i = 0; i < numFDs; i++) {
            char lhs = functionalDependencies[i][0];
            char rhs = functionalDependencies[i][2];

            if (isAttributePresent(closure, lhs) && !isAttributePresent(closure, rhs)) {
                closure[strlen(closure)] = rhs;
                closureChanged = true;
            }
        }
    }

    printf("Closure of attribute set {%s} is {%s}\n", attributes, closure);
}

int main() {
    char attributes[MAX_ATTRIBUTES];
    printf("Enter the attributes: ");
    scanf("%s", attributes);

    int numFDs;
    printf("Enter the number of functional dependencies: ");
    scanf("%d", &numFDs);

    char functionalDependencies[numFDs][MAX_ATTRIBUTES];
    for (int i = 0; i < numFDs; i++) {
        printf("Enter the functional dependency %d (in the form A->B): ", i + 1);
        scanf("%s", functionalDependencies[i]);
    }

    computeClosure(attributes, functionalDependencies, numFDs);

    return 0;
}
