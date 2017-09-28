#include <vector>
#include <list>
#include <algorithm>
#include <iomanip>
#include <iostream>
#include <fstream>
#include "stopwatch.hpp"

/*
 * For the vector, you may want to look into the following member functions
 *
 * 	insert - http://en.cppreference.com/w/cpp/container/vector/insert
 * 	push_back - http://en.cppreference.com/w/cpp/container/vector/push_back
 * 	begin - http://en.cppreference.com/w/cpp/container/vector/begin
 *
 * For the list, these may be helpful.
 *
 * 	push_front - http://en.cppreference.com/w/cpp/container/list/push_front
 * 	insert - http://en.cppreference.com/w/cpp/container/list/insert
 * 	push_back - http://en.cppreference.com/w/cpp/container/list/push_back
 *
 */

int main() {
	// for saving the timings
	std::vector<float> timings_f;
	std::vector<float> timings_m;
	std::vector<float> timings_e;

	std::vector<float> timings_if;
	std::vector<float> timings_im;
	std::vector<float> timings_ie;
	// a stopwatch in milliseconds
	stopwatch<std::milli, float> sw;

	// The number of integers in each test
	constexpr static size_t sizes[] = { 1<<8, 1<<9, 1<<10, 1<<11, 1<<12, 1<<13};
	std::vector<float> logf;
	std::vector<float> logm;
	std::vector<float> loge;

	std::vector<float> logif;
	std::vector<float> logim;
	std::vector<float> logie;

	for (auto size : sizes) {
		// std::vector is the "dynamically-allocated array" for C++
		std::vector<int> data_m;
		std::vector<int> data_f;
		std::vector<int> data_e;

		std::list<int> int_f;
		std::list<int> int_m;
		std::list<int> int_e;

		// Do 10 iterations to remove jitter from the timings
		for (size_t iter = 0; iter < 10; iter++) {

			sw.start();
			for (size_t n = 0; n < size ; n++){
				auto pos = data_f.begin();
				data_f.insert(pos,n);
			}
			sw.stop();
			timings_f.push_back(sw.count());
			data_f.clear();

			// Start the timer
			sw.start();
			for (size_t n = 0; n < size; n++) {
				// Part C: insert into middle
				auto pos = data_m.begin();
				std::advance(pos, data_m.size() / 2UL);
				data_m.insert(pos, n);
			}

			// stop the timer
			sw.stop();

			// save the wall time for the current iteration
			timings_m.push_back(sw.count());

			// empty the vector
			data_m.clear();


			sw.start();
			for (size_t n = 0; n < size ; n++){
				
				data_e.push_back(n);
			}
			sw.stop();
			timings_e.push_back(sw.count());
			data_e.clear();

			// List
			sw.start();
			for (size_t n = 0; n < size ; n++){
				int_f.push_front(n);
			}
			sw.stop();
			timings_if.push_back(sw.count());
			int_f.clear();


			sw.start();
			for (size_t n = 0; n < size ; n++){
				auto pos = int_m.begin();
				std::advance(pos, int_m.size() / 2UL);
				int_m.insert(pos, n);
			}
			sw.stop();
			timings_im.push_back(sw.count());
			int_m.clear();

			sw.start();
			for (size_t n = 0; n < size ; n++){
				int_e.push_back(n);
			}
			sw.stop();
			timings_ie.push_back(sw.count());
			int_e.clear();

			



		}

		// Calculate the minimum wall time
		const auto min_time_f = *std::min_element(timings_f.begin(), timings_f.end());
		const auto min_time_m = *std::min_element(timings_m.begin(), timings_m.end());
		const auto min_time_e = *std::min_element(timings_e.begin(), timings_e.end());

		const auto min_time_if = *std::min_element(timings_if.begin(), timings_if.end());
		const auto min_time_im = *std::min_element(timings_im.begin(), timings_im.end());
		const auto min_time_ie = *std::min_element(timings_ie.begin(), timings_ie.end());
		// Report the size and minimum time
		std::cout << std::fixed << std::setprecision(6) << size << " " << min_time_f << " "<< min_time_m <<" " << min_time_e  << '\n';

		std::cout << std::fixed << std::setprecision(6) << size << " " << min_time_if << " "<< min_time_im <<" " << min_time_ie  << '\n';

		logf.push_back(min_time_f);
		logm.push_back (min_time_m);
		loge.push_back (min_time_e);

		logif.push_back(min_time_if);
		logim.push_back(min_time_im);
		logie.push_back(min_time_ie);

		// clear the saved timings
		timings_f.clear();
		timings_e.clear();
		timings_m.clear();
		timings_if.clear();
		timings_ie.clear();
		timings_im.clear();


	}

	std::ofstream outfile1("problem1_list.out");
	std::ofstream outfile2("problem1_array.out");
	for (int i = 0; i < logf.size(); i++){
		outfile2 << std::fixed << std::setprecision(6) << sizes[i] << " "<<logf.at(i)<<'\n';
	}
	for (int i = 0; i < logm.size(); i++){
		outfile2 << std::fixed << std::setprecision(6) << sizes[i] << " "<<logm.at(i)<<'\n';
	}
	for (int i = 0; i < loge.size(); i++){
		outfile2 << std::fixed << std::setprecision(6) << sizes[i] << " "<<loge.at(i)<<'\n';
	}


	for (int i = 0; i < logif.size(); i++){
		outfile1 << std::fixed << std::setprecision(6) << sizes[i] << " "<<logif.at(i)<<'\n';
	}
	for (int i = 0; i < logim.size(); i++){
		outfile1 << std::fixed << std::setprecision(6) << sizes[i] << " "<<logim.at(i)<<'\n';
	}
	for (int i = 0; i < logie.size(); i++){
		outfile1 << std::fixed << std::setprecision(6) << sizes[i] << " "<<logie.at(i)<<'\n';
	}	
	





}
