using System;
using System.Collections.Generic;
using System.Diagnostics; 

class PostfixEvaluation {

    public static Stopwatch timer = new Stopwatch();

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
        string expression = "63*";
        int finalEvaluation = EvaluatePostfix(expression);

        /*
         *      Calculate Latency
         */

        timer.Restart();
        EvaluatePostfix(expression);
        timer.Stop();
        decimal latency = (decimal)timer.Elapsed.TotalMilliseconds;
        
        /*
         *      Calculate Throughput 
         */

        int iterations = 100000;
        timer.Restart();
        for (int i = 0; i < iterations; i++) {
            EvaluatePostfix(expression);
        }
        decimal throughput = iterations / (decimal)timer.Elapsed.TotalSeconds;

        Console.WriteLine("Postfix Evaluation : " + finalEvaluation);
        Console.WriteLine("Latency: " + latency + " ms per operation");
        Console.WriteLine($"Throughput: {throughput:F2} ops/sec");
    }
}
