using System;
using System.Collections.Generic;

class PostfixEvaluation {
    static int EvaluatePostfix(string expression) {
        Stack<int> stack = new Stack<int>();
        foreach (char c in expression) {
            if(char.IsDigit(c)) {
                stack.Push(c - '0'); // char -> int -> push to stack
            } else if (c == ' '){
                continue; 
            } else {
                int a = stack.Pop();
                int b = stack.Pop();
                switch(c) {
                    case '+':
                        stack.Push(a + b);
                        break;
                    case '-':
                        stack.Push(b - a);
                        break;
                    case '*':
                        stack.Push(a * b);
                        break;
                    case '/':
                        stack.Push(b / a);
                        break;
                }
            }
        }
        return stack.Pop();
    }
    static void Main(){
        /*string expression = "231*+9 - ";*/
        string expression = "63*";
        Console.WriteLine("Postfix Evaluation : " + EvaluatePostfix(expression));
    }
}
