/*
 * Shared definitions for Kleknev programs
 * Copyright (C) 2013  Matthew Skala
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Matthew Skala
 * http://ansuz.sooke.bc.ca/
 * mskala@ansuz.sooke.bc.ca
 */

#ifndef KLEKNEV_H
#define KLEKNEV_H

#define LF_MAGIC 0xF66E6C4B

#define LF_PID 1
#define LF_WALLTIME 2
#define LF_HOST 4
#define LF_PPID 8
#define LF_RUSAGE 16
#define LF_STATUS 32
#define LF_ARGV 64

#endif /* KLEKNEV_H */
