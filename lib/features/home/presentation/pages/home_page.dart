import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/home_provider.dart';
import '../../../../core/navigation/custom_navigator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../core/widgets/datetime_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().fetchLeads();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<HomeProvider>().fetchLeads();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Leads Dashboard'),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: () => context.read<HomeProvider>().refresh(),
      //     ),
      //   ],
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withValues(alpha: 0.05),
              Colors.white,
            ],
          ),
        ),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            if (homeProvider.leads.isEmpty && homeProvider.isLoading) {
              return const Center(child: CustomLoader());
            }

            if (homeProvider.errorMessage != null &&
                homeProvider.leads.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      homeProvider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Retry',
                      onPressed: () => homeProvider.refresh(),
                      width: 120,
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => homeProvider.refresh(),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount:
                    homeProvider.leads.length + (homeProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == homeProvider.leads.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomLoader(),
                      ),
                    );
                  }

                  final lead = homeProvider.leads[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // Handle lead tap, maybe navigate to detail
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: lead.leadStatusColor != null
                                  ? Color(
                                      int.parse(
                                        lead.leadStatusColor!.replaceFirst(
                                          '#',
                                          '0xff',
                                        ),
                                      ),
                                    )
                                  : Colors.grey.shade300,
                              child: Text(
                                lead.name?[0].toUpperCase() ?? '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lead.name ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  if (lead.email != null)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          lead.email!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (lead.phone != null)
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          lead.phone!,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: [
                                      if (lead.company != null)
                                        Chip(
                                          label: Text('🏢 ${lead.company}'),
                                          backgroundColor: Colors.blue.shade50,
                                          labelStyle: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      if (lead.leadSourceName != null)
                                        Chip(
                                          label: Text(
                                            '📍 ${lead.leadSourceName}',
                                          ),
                                          backgroundColor: Colors.green.shade50,
                                          labelStyle: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      if (lead.leadStatusName != null)
                                        Chip(
                                          label: Text(
                                            '📊 ${lead.leadStatusName}',
                                          ),
                                          backgroundColor:
                                              lead.leadStatusColor != null
                                              ? Color(
                                                  int.parse(
                                                    lead.leadStatusColor!
                                                        .replaceFirst(
                                                          '#',
                                                          '0xff',
                                                        ),
                                                  ),
                                                ).withValues(alpha: 0.1)
                                              : Colors.grey.shade50,
                                          labelStyle: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (lead.createdAt != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Created: ${DateTime.parse(lead.createdAt!).toDDMMYYYY()}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
