/*
 * Copyright (C) 2014 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dumpstate.h>

void dumpstate_board()
{
    dump_file("soc revision", "/sys/devices/soc0/revision");
    dump_file("soc die_id", "/sys/devices/soc0/soc_id");
    dump_file("shrinkers", "/d/shrinker");
    dump_file("display controller", "/d/tegradc.0/stats");
};
