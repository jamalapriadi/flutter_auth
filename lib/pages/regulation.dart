import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hsp_gate/components/loading_widget.dart';
import 'package:hsp_gate/cubit/member-type/member_type_cubit.dart';
import 'package:hsp_gate/cubit/member-type/member_type_state.dart';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:hsp_gate/helpers/constant.dart';

class Regulation extends StatefulWidget {
  const Regulation({Key? key}) : super(key: key);

  @override
  State<Regulation> createState() => _RegulationState();
}

class _RegulationState extends State<Regulation> {
  MembertypeCubit membertypeCubit = MembertypeCubit();

  @override
  void initState() {
    membertypeCubit.getMembertype();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Regulation"), backgroundColor: Warna.hijau),
        body: BlocProvider<MembertypeCubit>(
          create: (context) => membertypeCubit,
          child: BlocListener<MembertypeCubit, MembertypeState>(
            listener: (context, state) {},
            child: Stack(
              children: [
                BlocBuilder<MembertypeCubit, MembertypeState>(
                    builder: (context, state) {
                  if (state is LoadingMembertypeState) {
                    return const LoadingWidget();
                  } else if (state is GetMembertypeState) {
                    return _buildRegulation(state.membertypeResponse);
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegulation(reg) {
    final children = <AccordionSection>[];
    for (var i = 0; i < reg.length; i++) {
      children.add(
        AccordionSection(
          isOpen: true,
          // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
          headerBackgroundColor: Warna.biru,
          headerBackgroundColorOpened: Warna.hijau,
          header: Text(reg[i].name.toString()),
          content: Html(data: reg[i].regulation.toString()),
          contentHorizontalPadding: 20,
          contentBorderWidth: 1,
          // onOpenSection: () => print('onOpenSection ...'),
          // onCloseSection: () => print('onCloseSection ...'),
        ),
      );
    }

    return Accordion(
      maxOpenSections: 1,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: children,
    );
  }
}
