package com.examples.server;

import com.examples.models.TransferRequest;
import com.examples.models.TransferResponse;
import com.examples.models.TransferServiceGrpc;
import io.grpc.stub.StreamObserver;

public class TransferService extends TransferServiceGrpc.TransferServiceImplBase {
    @Override
    public StreamObserver<TransferRequest> transfer(StreamObserver<TransferResponse> responseObserver) {
        return new TransferStreamRequest(responseObserver);
    }
}
