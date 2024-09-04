package com.examples.server;

import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class AccountDatabase {
    private static final Map<Integer, Integer> MAP = IntStream
            .rangeClosed(1, 10)
            .boxed()
            .collect(Collectors.toMap(Function.identity(), v -> v * 10));

    public static int getBalance(int accountID){
        return MAP.get(accountID);
    }

    public static int addBalance(int accountID, int amount){
        return MAP.computeIfPresent(accountID, (k, v) -> v + amount);
    }

    public static int deductBalance(int accountID, int amount){
        return MAP.computeIfPresent(accountID, (k, v) -> v - amount);
    }

    public static void printAccountsInfo(){
        System.out.println(MAP);
    }
}
