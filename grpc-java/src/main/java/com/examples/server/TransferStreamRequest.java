package com.examples.server;

import com.examples.models.Account;
import com.examples.models.TransferRequest;
import com.examples.models.TransferResponse;
import com.examples.models.TransferStatus;
import io.grpc.stub.StreamObserver;

public class TransferStreamRequest implements StreamObserver<TransferRequest> {
    private StreamObserver<TransferResponse> streamObserver;

    public TransferStreamRequest(StreamObserver<TransferResponse> streamObserver) {
        this.streamObserver = streamObserver;
    }

    @Override
    public void onNext(TransferRequest transferRequest) {
        int fromAccount = transferRequest.getFromAccount();
        int toAccount = transferRequest.getToAccount();
        int amount = transferRequest.getAmount();
        int balance = AccountDatabase.getBalance(fromAccount);
        TransferStatus transferStatus = TransferStatus.FAILED;

        if(balance > amount && fromAccount != toAccount) {
            AccountDatabase.deductBalance(fromAccount, amount);
            AccountDatabase.addBalance(toAccount, amount);
            transferStatus = TransferStatus.SUCCESS;
        }

        TransferResponse transferResponse = TransferResponse
                .newBuilder()
                .setStatus(transferStatus)
                .addAccounts(
                        Account
                                .newBuilder()
                                .setAccountNumber(fromAccount)
                                .setAmount(AccountDatabase.getBalance(fromAccount))
                                .build()
                )
                .addAccounts(
                        Account
                                .newBuilder()
                                .setAccountNumber(toAccount)
                                .setAmount(AccountDatabase.getBalance(toAccount))
                                .build()
                )
                .build();

        this.streamObserver.onNext(transferResponse);
    }

    @Override
    public void onError(Throwable throwable) {
        System.out.println(throwable.getMessage());
    }

    @Override
    public void onCompleted() {
        System.out.println("Server is done!");
        AccountDatabase.printAccountsInfo();
        this.streamObserver.onCompleted();
    }
}
