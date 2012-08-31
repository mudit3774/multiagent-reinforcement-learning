#include <iostream>
#include <stdlib.h>
#include <time.h>

#define HISTORY 5000
#define NUM_AGENTS_NORMAL 500
#define NUM_AGENTS_BIAS 500
#define NUM_AGENTS 1000
#define OPTIMISM_BIAS .10	//Optimistic
#define PESSIMISM_BIAS .10
#define INIT_STOCK_VAL 100
#define VALUATION +1		//+1 UNDER-VALUED	-1 OVER-VALUED

using namespace std;

int main()
{
	srand(time(NULL));
	double I, Value, AddValue, ValueBias, ValueNoBias;
	Value = INIT_STOCK_VAL;
	for(int i=0;i<HISTORY;i++)
 	{
		I=rand()%100;
		I=I/100;
		AddValue = OPTIMISM_BIAS*I; //- PESSIMISM_BIAS*I;
		if(rand()%2)
			I=0-I;
		ValueBias = Value + I + AddValue;
		ValueNoBias = Value + I;
                Value = (NUM_AGENTS_BIAS*ValueBias + NUM_AGENTS_NORMAL*ValueNoBias)/NUM_AGENTS;
		cout<<"\n"<<Value;
	}
	return 0;	
	
}
