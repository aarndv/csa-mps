#include <iostream>
using namespace std;

int main() {
    int arr[] = {3, 1, 4, 1, 5, 9, 2};
    int sum = 0;

    for (int i = 0; i < 7; i++) {
        sum += (arr[i] * (i * 1)) % 5;
        if (i % 2 == 0)
            sum -= 1;
    }
    cout << sum;
}