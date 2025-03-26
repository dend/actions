import sys
import os
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

matplotlib.use('Agg')

arguments = sys.argv[1:]

print('Started with the following arguments:')
print(arguments)

source_folder = os.environ['SOURCE_FOLDER']

print(f'Source folder: {source_folder}')

game_data_path = os.path.join(source_folder, 'data')

for file in os.listdir(game_data_path):
	for root, dirs, files in os.walk(game_data_path):
		for file in files:
			if file.endswith('.tsv'):
				stats_path = os.path.join(root, file)
				asset_id = Path(stats_path).parent.parent.name
				asset_version_id = Path(stats_path).parent.name
				asset_type = Path(stats_path).parent.parent.parent.name

				print(f'Found statistics entity at {stats_path}')
				print(f'Data is related to {asset_type} asset {asset_id} with version {asset_version_id}.')

				df = pd.read_csv(stats_path, sep='\t', parse_dates=['SnapshotTime'])

				plt.rcParams['figure.figsize'] = [17, 10]
				plt.rcParams['font.size']=12                
				plt.rcParams['savefig.dpi']=100             
				plt.rcParams['figure.subplot.bottom']=.1

				ax = plt.gca()
				ax.ticklabel_format(axis="y", useOffset=False)

				save_path = os.path.join('media', 'charts', asset_type, asset_id, asset_version_id)
				save_path_ap = os.path.join(save_path, 'plot_all_plays.png')
				save_path_rp = os.path.join(save_path, 'plot_recent_plays.png')
				Path(save_path).mkdir(parents=True, exist_ok=True)

				plt.figure()
				plt.xticks(rotation=90)
				plt.plot(df.SnapshotTime, df.AllTimePlays)
				plt.savefig(save_path_ap, facecolor='white', dpi=plt.gcf().dpi)
				plt.close()

				plt.figure()
				plt.xticks(rotation=90)
				plt.plot(df.SnapshotTime, df.RecentPlays)
				plt.savefig(save_path_rp, facecolor='white', dpi=plt.gcf().dpi)
				plt.close()