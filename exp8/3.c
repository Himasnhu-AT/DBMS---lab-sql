#include <stdio.h>
#include <string.h>

#define MAX_ATTR 26

typedef struct {
    char lhs[MAX_ATTR];
    char rhs[MAX_ATTR];
} FunctionalDependency;

void computeClosure(FunctionalDependency F[], int numFDs, char attrSet[], char closure[]) {
    int i, j, k;
    int changed;

    strcpy(closure, attrSet);

    do {
        changed = 0;

        for (i = 0; i < numFDs; i++) {
            int lhsLen = strlen(F[i].lhs);
            int rhsLen = strlen(F[i].rhs);

            int isSubset = 1;
            for (j = 0; j < lhsLen; j++) {
                if (strchr(closure, F[i].lhs[j]) == NULL) {
                    isSubset = 0;
                    break;
                }
            }

            if (isSubset) {
                for (k = 0; k < rhsLen; k++) {
                    if (strchr(closure, F[i].rhs[k]) == NULL) {
                        closure[strlen(closure)] = F[i].rhs[k];
                        changed = 1;
                    }
                }
            }
        }
    } while (changed);
}

int main() {
    FunctionalDependency F[] = {
        {"AB", "C"},
        {"C", "D"}
    };

    int numFDs = sizeof(F) / sizeof(F[0]);

    char attrSet[MAX_ATTR] = "AB";

    char closure[MAX_ATTR];
    computeClosure(F, numFDs, attrSet, closure);

    printf("Closure of F: %s\n", closure);

    return 0;
}

// /tmp/uCsf17gWUV.o
// Closure of F: ABCD


// === Code Execution Successful ===