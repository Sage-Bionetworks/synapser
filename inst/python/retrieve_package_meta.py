def retrieve_package_meta(package):
    import requests
    # Request package metadata json from PYPI
    return requests.get(f'https://pypi.org/pypi/{package}/json').json()

def get_latest_version(package=None, meta=None):
    # Return the latest release version or None
    meta = meta if meta else retrieve_package_meta(package)
    return meta.get('info', {}).get('version')

def get_release(package=None, meta=None, version='latest', packagetype='sdist'):
    # Return metadata for a specific release
    meta = meta if meta else retrieve_package_meta(package)
    version = get_latest_version(meta=meta) if version == 'latest' else version
    if version:
        release = meta.get('releases').get(version)
        if release:
            try:
                return next(x for x in release if x['packagetype'] == packagetype and not x['yanked'])
            except:
                return None



# Example usage
# meta = retrieve_package_meta('synapseclient')
# version = get_latest_version(meta=meta)
# version = get_latest_version('synapseclient')
# print(version)

# release = get_release(meta=meta)
# release = get_release(meta=meta, version=version)
# release = get_release('synapseclient', version='2.6.0', packagetype='bdist_wheel')
# release = get_release('synapseclient')
# print(release)
# url = release['url'] if release else None
# print(url)

