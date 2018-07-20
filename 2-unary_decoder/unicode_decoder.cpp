#include <iostream>
#include <string>
#include <bitset>

using namespace std;

int main()
{
    string MESSAGE;
    getline(cin, MESSAGE);
    bitset<7> letters [ MESSAGE.length() ];
    string encode;
    string characters;

    for (int i = 0; i < MESSAGE.length();i++) {
        bitset<7> bits(MESSAGE[i]);
        characters += bits.to_string();
    }

    for (int j = 0; j < characters.length(); j++) {
        if (characters[j] == '1') {
            if (j == 0) {
                encode += "0 0";
            } else {
                if (characters[j - 1] == '1') {
                    encode += "0";
                } else {
                    encode += " 0 0";
                }
            }
        } else {
            if (j == 0) {
                encode += "00 0";
            } else {
                if (characters[j - 1] == '0') {
                  encode += "0";
                } else {
                    encode += " 00 0";
                }
            }
        }
    }

    cout << encode << endl;
}
