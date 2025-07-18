
### preceeding code gets us self.classes
# also def q, p (power is q), d, r,s t, r' = rp , t' = tp defined 
UCF = UniversalCyclotomicField() 
eps = UCF.gen(r) # epsilon as an rth root of unity

self.characters = [{}]
for g in self.classes:
    # ex: C_6^{1,2,3}
    # C_4^k{
    i = int(g[2]) 
    k,l,m = 0,0,0 
    if i in [3,4,5,7,8]:
        k = int(g[4:])
    elif i == 6:
        k,l,m = map(int,g[5:-1].split(',')

    if i == 1: 
        self.characters[0][g] = q * s 
    elif i == 2: 
        self.characters[0][g] = -q
    elif i == 3: 
        self.characters[0][g] = 0 
    elif i == 4: 
        self.characters[0][g] = -s
    elif i == 5: 
        self.characters[0][g] = 1 
    elif i == 6: 
        self.characters[0][g] = 2
    elif i == 7: 
        self.characters[0][g] = 0
    elif i == 8: 
        self.characters[0][g] = -1
    
    for u in range(1,rp):
        if i == 1: 
            self.characters[u][g] = t 
        elif i == 2: 
            self.characters[u][g] = -s 
        elif i == 3: 
            self.characters[u][g] = 1
        elif i == 4: 
            self.characters[0][g] = -s * eps^(3 * u * k) + eps^(-6 * u * k)  
        elif i == 5: 
            self.characers[0][g] = eps^(3 * u * k) + eps^(-6 * u * k) 
        elif i == 6 : 
            if g[-1] == "'": 
                self.characters[0][g] = 3
            else: 
                self.characters[0][g] = eps^(3 * u * k) + eps^(3 * u* l) + eps^(3 * u * m) 
        elif i == 7: 
            self.characters[0][g] = eps^(3 * u * k) 
        elif i == 8: 
            self.characters[0][g] = 0 
    return self.characters 


"""
File used for testing and running our production code 
"""
load("group_characters.sage")
load("suzuki_characters.sage")
load("psu_characters.sage")
load("helper_functions.sage")

import json
import os
import time
from datetime import datetime

def save_output(data):
    with open("RD-bounds.json", "a") as f:
        f.write(json.dumps(data) + "\n")


# in case we don't like new version
for q in [3]:
    G = GroupCharacters(f"PSU(3, {q})")
    result = G.the_game(G.characters[1],10)
    save_output(result)

'''
def check_previous_runs(): 
    # retrieve a list of the q's we have in .json by checking string
    seen = set()
    if not os.path.exists("RD-bounds.json"):
        return seen 
    with open("RD-bounds.json","r") as f: 
        for line in f: 
            try: 
                if f"PSU(3, " in line:
                    q = line.split("PSU(3, ")[1].split(")")[0].strip()
                    q = int(q)
                    seen.add(q)
            except (IndexError, ValueError): 
                pass
    return seen

"""
this doesnt work yet mb
"""

def run_with_time(q): 
    g_name = f"PSU(3, {q})" 
    try: 
        start_time = time.time()
        G = GroupCharacters(g_name)
        output = G.the_game(G.characters[1], 10) 
        result.update(output) 
        result["status"] = "Success!" 
    except MemoryError: 
        result["status"] = "Ran out of memory"
    except Exception as e: 
        result["status"] = "Failed" 
        result["notes"] = f"{e}" 
    end_time = time.time()
    result["approx_run_length"] = round(end_time - start_time, 2) 
    result["time"] = datetime.now().isoformat()

    with open("RD-bounds.json", "a") as f: 
        f.write(json.dumps(result) + "\n")


for q in [3]: 
    seen = check_previous_runs()
    if q in seen: 
        print(f"We already ran q = {q} silly") 
    else: 
        print(f"Now running q = {q}, hold please!")

        G = GroupCharacters(f"PSU(3, {q})")
        result = G.the_game(G.characters[1],10)
        result_info = G.display(decimal=False)
        run_with_time(q) 
        #save_output(result)
'''
        
   
