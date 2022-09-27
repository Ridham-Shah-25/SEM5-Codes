
// Ridham Shah
// PG-41
#include <iostream>
#include <string>
using namespace std;

string encrypt(string message, int key)
{
	string result = "";
	for (int i = 0; i < message.size(); i++)
	{
		char msg = message[i];
		if (msg >= 'a' && msg <= 'z')
		{
			msg += key;
			if (msg > 'z')
			{
				msg = msg - 'z' + 'a' - 1;
			}
			result += msg;
		}
		else
		{

			msg += key;
			if (msg > 'Z')
			{
				msg = msg - 'Z' + 'A' - 1;
			}
			result += msg;
		}
	}

	return result;
}

string decrypt(string message, int key)
{
	string result = "";
	for (int i = 0; i < message.size(); i++)
	{
		char msg = message[i];
		if (msg >= 'a' && msg <= 'z')
		{
			msg -= key;
			if (msg < 'a')
			{
				msg = msg + 'z' - 'a' + 1;
			}
			result += msg;
		}
		else
		{

			msg -= key;
			if (msg < 'A')
			{
				msg = msg + 'Z' - 'A' + 1;
			}
			result += msg;
		}
	}

	return result;
}

int main()
{

	string message;
	cout << "\nEnter the string: ";
	cin >> message;
	int key;
	cout << "\nEnter the key: ";
	cin >> key;
	cout << "\nThe Encrypted message is : " << encrypt(message, key);
	cout << "\nThe Decrypted message is : " << decrypt(encrypt(message, key), key);
	return 0;
}
