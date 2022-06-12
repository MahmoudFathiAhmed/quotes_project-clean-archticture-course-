import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';
import 'package:quotes/core/widgets/error_widget.dart' as error_widget;
import 'package:quotes/features/presentation/cubit/random_quote_cubit.dart';
import 'package:quotes/features/presentation/widgets/quote_content.dart';


class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote()=> BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();

  @override
  initState(){
    super.initState();
    _getRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text(AppStrings.appName),
    );
    return RefreshIndicator(child: Scaffold(
        appBar: appBar,
        body: Center(
          child: buildBodyContent(),
        ),
      ), onRefresh: ()=>_getRandomQuote(),
        );
  }
  Widget buildBodyContent(){
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState> (
        builder: (context, state){
          if (state is RandomQuoteIsLoading) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }else if (state is RandomQuoteError){
            return const error_widget.ErrorWidget();
          }else if (state is RandomQuoteLoaded){
            return Column(
              children: [
                QuoteContent(quote: state.quote),
                InkWell(
                  onTap: ()=> _getRandomQuote(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(Icons.refresh,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }
        }
    );
  }
}
