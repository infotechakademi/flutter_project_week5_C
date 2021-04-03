import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project19/bloc/service_req_bloc.dart';
import 'package:project19/bloc/service_req_state.dart';

class AdminViewPage extends StatefulWidget {
  @override
  _AdminViewPageState createState() => _AdminViewPageState();
}

class _AdminViewPageState extends State<AdminViewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceReqsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yönetici Ekranı"),
        ),
        body: BlocConsumer<ServiceReqsCubit, ServiceReqState>(
          listener: (BuildContext context, ServiceReqState serviceReqState) {
            print("Listener called");
          },
          builder: (BuildContext context, ServiceReqState serviceReqState) {
            if (serviceReqState is ServiceReqInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hoş Geldiniz"),
                    TextButton(
                        onPressed: () {
                          context.read<ServiceReqsCubit>().getServiceReqs();
                        },
                        child: Text("İstekleri Getir"))
                  ],
                ),
              );
            } else if (serviceReqState is ServiceReqLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (serviceReqState is ServiceReqCompleted) {
              return ListView.builder(
                  itemCount: serviceReqState.serviceReqList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(serviceReqState.serviceReqList[index].title),
                      subtitle:
                          Text(serviceReqState.serviceReqList[index].details),
                    );
                  });
            } else {
              return Center(child: Text("Hata Oluştu"));
            }
          },
        ),
      ),
    );
  }
}
