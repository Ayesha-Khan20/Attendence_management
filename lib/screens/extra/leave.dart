import 'package:flutter/material.dart';
import '../../models/leave.dart';


class LeaveApprovalScreen2 extends StatefulWidget {
  const LeaveApprovalScreen2({super.key});

  @override
  _LeaveApprovalScreenState createState() => _LeaveApprovalScreenState();
}

class _LeaveApprovalScreenState extends State<LeaveApprovalScreen2> {
  final List<Leave> leaveRequests = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Leave? newLeaveRequest =
        ModalRoute.of(context)!.settings.arguments as Leave?;
    if (newLeaveRequest != null) {
      setState(() {
        leaveRequests.add(newLeaveRequest);
      });
    }
  }

  void approveLeave(Leave leave) {
    setState(() {
      leave.isApproved = true;
    });
  }

  void rejectLeave(Leave leave) {
    setState(() {
      leave.isApproved = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Approval'),
      ),
      body: ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          Leave leave = leaveRequests[index];

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Name: ${leave.name} - ${leave.startDate.toLocal()} to ${leave.endDate.toLocal()}'),
                Text('Email: ${leave.email}'),
                Text('Reason: ${leave.reason}'),
              ],
            ),
            subtitle: Text('Status: ${leave.isApproved ? 'Approved' : 'Pending'}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: () => approveLeave(leave),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => rejectLeave(leave),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
