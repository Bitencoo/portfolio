package com.example.client.rpctypes;

import com.example.models.Money;
import io.grpc.stub.StreamObserver;

import java.util.concurrent.CountDownLatch;

public class MoneyStreamingResponse implements StreamObserver<Money> {

    private CountDownLatch latch;
    public MoneyStreamingResponse(CountDownLatch moneyCountDownLatch){
        this.latch = moneyCountDownLatch;
    }

    @Override
    public void onNext(Money money) {
        System.out.println("Receiving money... " + money.getAmount());
    }

    @Override
    public void onError(Throwable throwable) {
        System.out.println(throwable.getMessage());
        latch.countDown();
    }

    @Override
    public void onCompleted() {
        System.out.println("Received the money successfully!");
        latch.countDown();
    }
}
