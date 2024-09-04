package com.example.client.rpctypes;

import com.example.models.Balance;
import io.grpc.stub.StreamObserver;

import java.util.concurrent.CountDownLatch;

public class BalanceStreamingObserver implements StreamObserver<Balance> {
    private CountDownLatch latch;

    public BalanceStreamingObserver(CountDownLatch latch) {
        this.latch = latch;
    }

    @Override
    public void onNext(Balance balance) {
        System.out.println("Final balance: " + balance.getAccountBalance());
    }

    @Override
    public void onError(Throwable throwable) {
        System.out.println(throwable.getMessage());
    }

    @Override
    public void onCompleted() {
        System.out.println("Server is done!");
    }
}
